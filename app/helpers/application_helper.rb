module ApplicationHelper
  def format_preco(preco)
    preco_str = preco.to_s
    reais = preco_str[0..-3].reverse.scan(/\d{1,3}/).join(".").reverse
    cents = preco_str[-2..]
    "#{reais},#{cents}"
  end
end
