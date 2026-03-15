get "/history" do
  content_type :json

  if session[:user_id]

    messages = Message.history(session[:user_id])

    { messages: messages }.to_json

  else

    { messages: [] }.to_json

  end
end

get "/conversations" do
  content_type :json

  conversations = Conversation.list(session[:user_id])

  { conversations: conversations }.to_json
end

post "/chat" do
  content_type :json

  data = JSON.parse(request.body.read)
  messages = data["messages"] || []

  prompt = <<~PROMPT
  Você é um tutor educacional chamado EstudaEasy.

  Regras obrigatórias:

  - Responda sempre em português do Brasil.
  - Use parágrafos longos e bem desenvolvidos.
  - Evite respostas curtas ou superficiais.
  - NÃO escreva seções chamadas "Em resumo", "Resumo" ou "Resumindo".
  - Só faça resumo se o usuário pedir explicitamente.

  PROMPT

  messages.each do |m|
    role = m["role"] == "user" ? "Usuário" : "Assistente"
    prompt << "#{role}: #{m['content']}\n"
  end

  prompt << "Assistente:"

  uri = URI(OLLAMA_URL)

  body = {
    model: "gemma3:1b",
    prompt: prompt,
    stream: false,
    options: {
      temperature: 0.4,
      top_p: 0.9,
      num_predict: 500
    }
  }.to_json

  response = Net::HTTP.post(uri, body, "Content-Type" => "application/json")
  json = JSON.parse(response.body)

  reply = json["response"] || "Erro ao gerar resposta."

  reply = reply.gsub(/Em resumo:?.*/i, "")
  reply = reply.gsub(/Resumindo:?.*/i, "")
  reply = reply.strip

  { reply: reply }.to_json
end