# encoding: utf-8

class MostViewedProcessor

  attr_reader :items

  def initialize settings, section
    @settings = settings
    @editorial = find_editorial section

    @items = []

    @repo = MyRepo.new @settings

    @url_rules  = get_editorial_config 'url_rules'
    @site_rules =  get_editorial_config 'site_rules'
  end

  def find_editorial name
    if @settings.editorias.has_key? name
      @settings.editorias[name]
    else
      raise 'Editoria não encontrada;'
    end
  end

  def search_items
    @editorial['files'].each do |file|
      @items += @repo.load_items file
    end

    filter_items if @site_rules or @url_rules
    sort_items
  end

  def filter_items
    @items.select! { |item| match_site_or_url item }
  end

  private
  def sort_items
    @items.sort! do |k,y|
      y[:views] <=> k[:views]
    end
  end

  def match_site_or_url item
    match = nil
    
    match = item if @site_rules.detect { |rule| item[:site].downcase =~ /#{rule}/ }
    match = item if match.nil? and @url_rules and @url_rules.detect{ |rule| item[:url] =~ /#{rule}/ }

    match
  end

  def get_editorial_config config_key
    @editorial[config_key] if @editorial.has_key? config_key
  end
end
