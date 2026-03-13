
# app.rb
require "sinatra"
require "json"
require "net/http"
require "uri"
require "dotenv/load"

set :bind, ENV["APP_HOST"]
set :port, ENV["APP_PORT"]

OLLAMA_URL = ENV["API_URL"]

get "/" do
  erb :home
end

get "/chat" do
  erb :index
end

post "/chat" do
  content_type :json

  data = JSON.parse(request.body.read)
  messages = data["messages"] || []

  prompt = <<~PROMPT
  Você é um tutor educacional chamado InteligenceIO.

  Regras obrigatórias:

  - Responda sempre em português do Brasil.
  - Explique os conceitos de forma clara e didática.
  - Use parágrafos curtos ou tópicos.
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
      num_predict: 300
    }
  }.to_json

  response = Net::HTTP.post(uri, body, "Content-Type" => "application/json")
  json = JSON.parse(response.body)

  reply = json["response"] || "Erro ao gerar resposta."

  # remove resumo automático
  reply = reply.gsub(/Em resumo:?.*/i, "")
  reply = reply.gsub(/Resumindo:?.*/i, "")
  reply = reply.strip

  { reply: reply }.to_json
end