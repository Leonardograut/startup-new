# EstudaEasy Chat Inteligente 💬

Uma aplicação de chat em tempo real construída com Ruby/Sinatra e PostgreSQL.

## 🛠️ Tecnologias Utilizadas

- **[Sinatra](http://sinatrarb.com/)** - Framework web Ruby leve e flexível
- **[Ruby](https://www.ruby-lang.org/)** - Linguagem de programação
- **[PostgreSQL](https://www.postgresql.org/)** - Banco de dados relacional
- **[Puma](https://puma.io/)** - Servidor web Ruby
- **[Rack](https://rack.github.io/)** - Interface padrão para aplicações web Ruby
- **[Rackup](https://github.com/rack/rackup)** - Servidor de desenvolvimento
- **[Dotenv](https://github.com/bkeepers/dotenv)** - Carregamento de variáveis de ambiente
- **[ERB](https://ruby-doc.org/stdlib/libdoc/erb/rdoc/ERB.html)** - Template engine para views
- **[JSON](https://www.json.org/)** - Formato de dados para API

## 📋 Pré-requisitos

Antes de começar, certifique-se de que você tem instalado:

- **Ruby** (versão 2.7 ou superior) - [Download](https://www.ruby-lang.org/en/downloads/)
- **PostgreSQL** (versão 12 ou superior) - [Download](https://www.postgresql.org/download/)
- **Bundler** - Gerenciador de dependências Ruby (instale com `gem install bundler`)
- **Git** (opcional, para clonar o repositório)

## ⚙️ Instalação

### 1. Clone ou baixe o repositório

```bash
git clone <seu-repositorio>
cd chatruby
```

### 2. Instale as dependências

```bash
bundle install
```

Este comando instala todas as gems listadas no `Gemfile`.

### 3. Configure as variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto com as seguintes variáveis:

```env
DATABASE_URL=postgres://usuario:senha@localhost:5432/chatruby_db
PORT=4567
RACK_ENV=development
```

**Ou configure manualmente:**

```bash
# No Windows (PowerShell)
$env:DATABASE_URL="postgres://usuario:senha@localhost:5432/chatruby_db"
$env:PORT="4567"
$env:RACK_ENV="development"

# No Linux/Mac (Bash)
export DATABASE_URL="postgres://usuario:senha@localhost:5432/chatruby_db"
export PORT="4567"
export RACK_ENV="development"
```

### 4. Configure o banco de dados

Crie o banco de dados PostgreSQL:

```bash
createdb chatruby_db
```

Execute as migrações (se existirem):

```bash
ruby config/database.rb
```

## 🚀 Como Rodar o Projeto

### Opção 1: Com Rackup

```bash
rackup
```

A aplicação estará disponível em `http://localhost:9292`

### Opção 2: Com Puma

```bash
bundle exec puma
```

A aplicação estará disponível em `http://localhost:9292`

### Opção 3: Com Ruby direto

```bash
ruby app.rb
```

A aplicação estará disponível em `http://localhost:4567` (porta padrão do Sinatra)

## 📁 Estrutura do Projeto

```
chatruby/
├── app.rb                    # Arquivo principal da aplicação
├── config.ru                 # Configuração Rack
├── Gemfile                   # Dependências do projeto
├── README.md                 # Este arquivo
│
├── config/
│   └── database.rb          # Configuração do banco de dados
│
├── controller/
│   ├── auth_controller.rb   # Controlador de autenticação
│   ├── chat_controller.rb   # Controlador de chat
│   └── page_controller.rb   # Controlador de páginas
│
├── models/
│   ├── user.rb              # Modelo de usuário
│   ├── message.rb           # Modelo de mensagem
│   └── conversation.rb      # Modelo de conversa
│
├── public/
│   └── css/
│       └── style.css        # Estilos CSS
│
└── views/
    ├── home.erb             # Página inicial
    ├── index.erb            # Página principal
    ├── login.erb            # Página de login
    └── register.erb         # Página de registro
```

## 🔐 Recursos Principais

- ✅ Sistema de autenticação de usuários
- ✅ Criação e gerenciamento de conversas
- ✅ Envio e recebimento de mensagens
- ✅ Interface responsiva com CSS
- ✅ Persistência de dados em PostgreSQL

## 🐛 Troubleshooting

### Erro de conexão com o banco de dados

```
PG::ConnectionBad: could not connect to server
```

**Solução:**
- Verifique se PostgreSQL está em execução
- Confirme as credenciais no `.env` ou variáveis de ambiente
- Certifique-se de que o banco de dados foi criado

### Porta já em uso

```
Address already in use - bind(2) for 127.0.0.1:4567
```

**Solução:**
```bash
# Mude a porta no arquivo .env
PORT=5000
```

### Gems não encontradas

```
Bundler couldn't find some gems
```

**Solução:**
```bash
bundle install
bundle update
```

## 📚 Documentação Adicional

- [Documentação Sinatra](http://sinatrarb.com/intro.html)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Ruby Gems](https://rubygems.org/)


## 👨‍💻 Autor

Leonardo Nascimento de  Santana

Desenvolvido com ❤️ em Ruby

---

