require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'csv'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Reporte de peticiones a Jobs'.freeze
CREDENTIALS_PATH = 'credentials.json'.freeze

TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

def valid_date?(date)
  return false unless date&.match(/\d{4}\/\d{2}\/\d{2}/)
  real_date?(date)
end

def real_date?(date)
  date = date.gsub('/', '-')
  begin
    Date.strptime(date, '%Y-%m-%d')
  rescue
    false
  end
end

def valid_number?(number)
  !!/\d/.match(number)
end

def authorize
  client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts 'Abre el link en tu explorador y autoriza la cuenta que deseas ligar ' \
         ":\n" + url
    print 'Pega aquí el código brindado: '
    user_input = gets
    if user_input == "\n"
      puts 'Intenta de nuevo. Asegurate de pegar el código'
      exit
    else
      code = user_input
    end
    begin
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
    rescue
      puts "\nCódigo invalido. Intenta de nuevo"
      exit
    end
  end
  credentials
end

# Initialize the API
service = Google::Apis::GmailV1::GmailService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

puts '--Todos los campos son opcionales--'
print "\nIngresa una fecha inicial (YYYY/MM/DD): "
start_date = gets

request_params = ''
if valid_date?(start_date)
  request_params+= ' after: ' + start_date
else
  puts 'Error en el parámetro, este sera ignorado' if start_date != "\n"
end

print 'Ingresa una fecha final (YYYY/MM/DD): '
end_date = gets
if valid_date?(end_date)
  request_params+= ' before: ' + end_date
else
  puts 'Error en el parámetro, este sera ignorado' if end_date != "\n"
end

print 'Límite de correos: '
aux = gets
if valid_number?(aux)
  limit = aux.to_i if valid_number?(aux)
else
  puts 'Error en el parámetro, este sera ignorado' if aux != "\n"
end

@process = true

Thread.new do
  while @process do
    print '.'
    sleep 1
  end
end

sender_data = {}

loop do
  emails = service.list_user_messages(
            'me',
            max_results: limit,
            q: request_params
          )

  if set = emails.messages
    set.each do |message|
      email = service.get_user_message('me', message.id)
      email_sended = email.payload.headers.find {|header| header.name == "From" }.value
      sender_email = email_sended[/#{'<'}(.*?)#{'>'}/m, 1]
      sender_name = email_sended.split('<')[0]
      sender_data[sender_email] = sender_name
    end
  end

  limit =  limit - emails.messages.count  if limit
  puts ''
  break if !emails.next_page_token || ( !limit.nil? && limit == 0)
end

headers = [ 'Nombre', 'Email']
CSV.open("CVs_de_solicitantes.csv", "wb") do |csv|
  csv << headers
  sender_data.each do |email, user_name|
    csv << [user_name, email]
  end
end

@process =  false

exec "open CVs_de_solicitantes.csv"
