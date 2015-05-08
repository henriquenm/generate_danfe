require 'rubygems'
require 'bundler/setup'
require 'prawn'
require 'qr4r'
require "prawn/measurement_extensions"

class Company
  attr_accessor :id, :name, :trading_name, :registration_number,
  :state_registration_number, :municipal_registration_number, :phone_number

  def initialize(id, name, trading_name, registration_number,
                state_registration_number, municipal_registration_number, phone_number)
    @id = id
    @name = name
    @trading_name = trading_name
    @registration_number = registration_number

    @state_registration_number = state_registration_number
    @municipal_registration_number = municipal_registration_number
    @phone_number = phone_number
  end

end

company = Company.new(1, "MIRIAM CALAZANS DOS SANTOS 68946392134", "RDSCodes Inc.", "11.945.567/0001-57", "13.393.454-3", "123456789", :phone_number => "991095050")

Qr4r::encode('http://www.sefaz.mt.gov.br/nfce/consultanfce?chNFe=51131207212380000177650010000000711000000712', 'qrcode.png')

Prawn::Font::AFM.hide_m17n_warning = true
Prawn::Document.generate("danfe.pdf") do
  image "novo_logo_nfce_dark.png", width: 100
  move_down -1.cm
  str = "#{company.name}\nCNPJ: #{company.registration_number} IE: #{company.state_registration_number}\nRua Tenente Gomes Ribeiro, 182, Cj. 104, Vila Clementino, São Paulo - SP"
  text_box str, at: [120, cursor]
  move_down 1.3.cm
  text "________________________________________________________________________________", style: :bold, align: :center
  move_down 3.mm
  str = "DANFE NFCE-e Documento Auxiliar da Nota Fiscal de Consumidor Eletrônica\nNão permite aproveitamento de crédito de ICMS"
  text "#{str}", align: :center
  text "________________________________________________________________________________", style: :bold, align: :center
  move_down 3.mm
  text_box "QTD. TOTAL DE ITENS", at: [0, cursor]
  text "99", align: :right
  text_box "VALOR TOTAL R$", at: [0, cursor]
  text "99.99", align: :right
  text_box "FORMA DE PAGAMENTO", at: [0, cursor]
  text "Valor Pago", align: :right
  text_box "Dinheiro", at: [0, cursor]
  text "99.99", align: :right
  text "________________________________________________________________________________", style: :bold, align: :center
  move_down 3.mm
  text_box "Informações dos Tributos Totais Incidentes (Lei Federal 12.741 /2012)", at: [0, cursor]
  text "999.9", align: :right
  text "________________________________________________________________________________", style: :bold, align: :center
  move_down 4.mm
  str = "EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL\nNº:00 Série: 00 Emissão: 00/00/0000 00:00:00\n
  Via consumidor\nConsulte pela chave de acesso em:\nhttp://www.sefaz.mt.gov.br/nfce/consultanfce\nCHAVE DE ACESSO\n00000000000000000000000000000000000000000000"
  text "#{str}", align: :center
  text "________________________________________________________________________________", style: :bold, align: :center
  move_down 4.mm
  text "CONSUMIDOR NÃO IDENTIFICADO", align: :center
  text "________________________________________________________________________________", style: :bold, align: :center
  move_down 4.mm
  text "Consulta via leitor de QR Code", align: :center
  move_down 4.mm
  image "qrcode.png", at: [190, cursor]
  move_down 6.5.cm
  text "Protocolo de autorização: 000000000000000  00/00/0000 00:00:00", align: :center
end
