require "net/http"
require "json"
require "uri"

enable :sessions

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
  
  user_id = session[:user_id]

  data = JSON.parse(request.body.read)
  messages = data["messages"] || []

  user_message = messages.last["content"]

  Message.save(user_id, "user", user_message)

  api_messages = [
    {
      role: "system",
      content: <<~PROMPT
      Você é um tutor educacional chamado EstudaEasy.

      Regras obrigatórias:

      - Responda sempre em português do Brasil.
      - Use parágrafos longos e bem desenvolvidos.
      - Evite respostas curtas ou superficiais.
      - NÃO escreva "Em resumo", "Resumo" ou "Resumindo".
      - Só faça resumo se o usuário pedir explicitamente.
      PROMPT
    }
  ]

  messages.each do |m|
    api_messages << {
      role: m["role"], 
      content: m["content"]
    }
  end

  uri = URI("https://api.groq.com/openai/v1/chat/completions")

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.path, {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{ENV['API_KEY']}"
  })

  request.body = {
    model: "llama-3.1-8b-instant",
    messages: api_messages,
    temperature: 0.4
  }.to_json

  response = http.request(request)

  if response.code != "200"
    error_msg = "Erro na API: #{response.code}"
    Message.save(user_id, "assistant", error_msg) 
    return { reply: error_msg }.to_json
  end

  json = JSON.parse(response.body)

  reply = json.dig("choices", 0, "message", "content") || "Erro ao gerar resposta."

  reply = reply.gsub(/Em resumo:?.*/i, "")
  reply = reply.gsub(/Resumindo:?.*/i, "")
  reply = reply.strip

  Message.save(user_id, "assistant", reply)

  { reply: reply }.to_json
end