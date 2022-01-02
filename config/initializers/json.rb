module JSON
  def parse(source, opts = {})
    Parser.new(source, **opts).parse
  end
end
