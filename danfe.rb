require 'rubygems'
require 'bundler/setup'
require 'prawn'
require 'qr4r'

Qr4r::encode('http://www.sefaz.mt.gov.br/nfce/consultanfce', 'qrcode.png', :border => 10)

Prawn::Document.generate("danfe.pdf") do
  text "Hello World!"
  image "qrcode.png"
end
