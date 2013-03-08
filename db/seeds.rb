#encoding: utf-8
require 'rss'
require 'sanitize'

module Categories
  def self.createNew
    Category.create(description: 'Esporte') unless Category.exists?(description: 'Esporte')
    Category.create(description: 'Economia') unless Category.exists?(description: 'Economia')
    Category.create(description: 'Mundo') unless Category.exists?(description: 'Mundo')
    Category.create(description: 'Entreterimento') unless Category.exists?(description: 'Entreterimento')
    Category.create(description: 'Tecnologia') unless Category.exists?(description: 'Tecnologia')
    Category.create(description: 'Saúde') unless Category.exists?(description: 'Saúde')
    Category.create(description: 'Ciência') unless Category.exists?(description: 'Ciência')
    Category.create(description: 'Últimas Notícias') unless Category.exists?(description: 'Últimas Notícias')
  end
end

Categories.createNew

module RSSlink

  def self.link
    array = [
              #home
             {url: 'http://br.noticias.yahoo.com/rss/', category: 8},
             {url: 'http://feeds.folha.uol.com.br/emcimadahora/rss091.xml', category: 8},
             {url: 'http://www.band.uol.com.br/rss/noticias.xml', category: 8},
             {url: 'http://rss.uol.com.br/feed/noticias.xml', category: 8},
             {url: 'http://g1.globo.com/dynamo/rss2.xml', category: 8},
             {url: 'http://www.terra.com.br/rss/', category: 8},
              #esportes
             {url: 'http://br.esporteinterativo.yahoo.com/?format=rss', category: 1},
             {url: 'http://feeds.folha.uol.com.br/folha/esporte/rss091.xml', category: 1},
             {url: 'http://www.band.uol.com.br/rss/esporte.xml', category: 1},
             {url: 'http://esporte.uol.com.br/ultimas/index.xml', category: 1},
             {url: 'http://globoesporte.globo.com/dynamo/rss2.xml', category: 1},
             {url: 'http://esportes.terra.com.br/rss/Controller?channelid=2d19f517cd779310VgnVCM5000009ccceb0aRCRD&ctName=atomo-noticia&lg=pt-br', category: 1},
              #economia
             {url: 'http://feeds.folha.uol.com.br/folha/dinheiro/rss091.xml', category: 2},
             {url: 'http://www.band.uol.com.br/rss/economia.xml', category: 2},
             {url: 'http://rss.uol.com.br/feed/economia.xml', category: 2},
             {url: 'http://g1.globo.com/dynamo/economia/rss2.xml', category: 2},
             {url: 'http://br.noticias.yahoo.com/economia/?format=rss', category: 2},
             {url: 'http://economia.terra.com.br/rss/portada/pt-br/feedrss.xml', category: 2},
              #mundo
             {url: 'http://feeds.folha.uol.com.br/folha/mundo/rss091.xml', category: 3},
             {url: 'http://www.band.uol.com.br/rss/mundo.xml', category: 3},
             {url: 'http://g1.globo.com/dynamo/mundo/rss2.xml', category: 3},
             {url: 'http://br.noticias.yahoo.com/mundo/?format=rss', category: 3},
             {url: 'http://noticias.terra.com.br/rss/Controller?channelid=31b0316871bf3310VgnVCM3000009af154d0RCRD&ctName=atomo-noticia&lg=pt-br', category: 3},
              #entreterimento
             #{url: 'http://feeds.folha.uol.com.br/folha/dinheiro/rss091.xml', category: 5},
             #{url: 'http://www.band.uol.com.br/rss/economia.xml', category: 5},
             #{url: 'http://rss.uol.com.br/feed/economia.xml', category: 5},
             #{url: 'http://g1.globo.com/dynamo/economia/rss2.xml', category: 5},
             #{url: 'http://br.noticias.yahoo.com/economia/?format=rss', category: 5},
             #{url: 'http://economia.terra.com.br/rss/portada/pt-br/feedrss.xml', category: 5},
              #tecnologia
             {url: 'http://feeds.folha.uol.com.br/folha/informatica/rss091.xml', category: 5},
             {url: 'http://www.band.uol.com.br/rss/tecnologia.xml', category: 5},
             {url: 'http://tecnologia.uol.com.br/ultnot/index.xml', category: 5},
             {url: 'http://g1.globo.com/dynamo/tecnologia/rss2.xml', category: 5},
             {url: 'http://br.noticias.yahoo.com/tecnologia/?format=rss', category: 5},
             {url: 'http://noticias.terra.com.br/rss/Controller?channelid=b8443aca7323a310VgnVCM20000099cceb0aRCRD&ctName=atomo-noticia&lg=pt-br', category: 5},
              #Saúde
             {url: 'http://g1.globo.com/dynamo/ciencia-e-saude/rss2.xml', category: 6},
             {url: 'http://www.band.uol.com.br/rss/saude.xml', category: 6},
             {url: 'http://catracalivre.folha.uol.com.br/editoria/servicos/saude-bem-estar/feed/', category: 6},
             {url: 'http://feeds.folha.uol.com.br/folha/ciencia/rss091.xml', category: 6},
             {url: 'http://rss.uol.com.br/feed/saude.xml', category:6}
           ]
  end

end

module RSSnews

  def self.news(items, feed_id)

    items.each do |it|

      feed = Feed.find_by_id(feed_id)
      feedNews = feed.news
      if !feedNews.blank? && feedNews.exists?(link: it.link.to_s) && feedNews.exists?(title: it.title.to_s)
        next
      end

      @news = News.new

      @news.title = it.title.to_s
      @news.description = Sanitize.clean(it.description, elements: ['a', 'img'],
                                                       attributes: {'a' => ['href', 'target', 'type'],'img' => ['src', 'alt', 'ismap', 'usemap', 'title']})
      transformer = lambda do |env|
                      node = env[:node]
                      node_name = env[:node_name]
                      return if env[:is_whitelisted]
                      if node_name != '#document-fragment' && !node.element?
                        case node.parent.node_name
                        when nil
                          if node.content.blank?
                            return node.remove
                          end
                          node_to_insert = Nokogiri::XML::Node.new('p', node)
                        when "a"
                          if node.parent.elements != nil && node.parent.elements.detect {|n| n.node_name == 'img'}
                            return node.remove
                          else
                            node_to_insert = Nokogiri::XML::Node.new('h5', node)
                          end
                        else
                          return
                        end
                        node_to_insert.content = node.text.strip
                        node.add_previous_sibling(node_to_insert)
                        return node.remove
                      end
                      if node_name == 'a' && node.elements != nil && node.elements.detect {|n| n.node_name == 'img'}
                        node['class'] = 'linkImage'
                      end
                      if node_name == 'img' && node['src'] == nil
                        return Sanitize.clean_node!(node, {})
                      end
                    end

      @news.description = Sanitize.clean(@news.description, elements: ['a', 'img'],
                                                          #tem que permitir a class pois é adicionada em transformers
                                                          attributes: {'a' => ['href', 'target', 'class', 'type'],'img' => ['src', 'alt', 'ismap', 'usemap', 'title']},
                                                      add_attributes: {'a' => {'target' => '_blank'}, 'img' => {'alt' => 'image'}},
                                                        transformers: [transformer])
      @news.link = it.link.to_s
      @news.author = it.author.to_s
      @news.category_domain = it.categories.to_s
      @news.comments = it.comments.to_s
      @news.enclosure_url = it.enclosure.url.to_s if defined? it.enclosure.url
      @news.enclosure_length = it.enclosure.length.to_s if defined? it.enclosure.length
      @news.enclosure_type = it.enclosure.type.to_s if defined? it.enclosure.type
      @news.guid_is_perma_link = it.guid.to_s
      @news.pub_date = it.pubDate.to_s
      @news.source_url = it.source.to_s
      @news.feed_id = feed_id

      @news.save!

    end

  end

end

module RSSfeed

  def self.feeds

    RSSlink.link.each do |rssFeed|

      rss = RSS::Parser.parse(open(rssFeed[:url]).read, false)

      if Feed.exists?(rss_link: rssFeed[:url])
        existLink = Feed.where('rss_link = ?', rssFeed[:url]).first
        RSSnews.news(rss.items, existLink.id)
        next
      end

      feed = Feed.new
      feed.rss_link = rssFeed[:url]
      feed.xml_version = rss.feed_version.to_s
      feed.rss_version = rss.rss_version.to_s
      feed.title = rss.channel.title.to_s
      feed.link = rss.channel.link.to_s
      feed.description = rss.channel.description.to_s
      feed.language = rss.channel.language.to_s
      feed.copyright = rss.channel.copyright.to_s
      feed.managing_editor = rss.channel.managingEditor.to_s
      feed.web_master = rss.channel.webMaster.to_s
      feed.pub_date = rss.channel.pubDate.to_s
      feed.last_build_date = rss.channel.lastBuildDate.to_s
      feed.category_id = rssFeed[:category]
      feed.categories = rss.channel.categories.to_s
      feed.category_domain = rss.channel.category.domain.to_s if defined? rss.channel.category.domain
      feed.generator = rss.channel.generator.to_s
      feed.docs = rss.channel.docs.to_s
      feed.cloud_domain = rss.channel.cloud.domain.to_s if defined? rss.channel.cloud.domain
      feed.cloud_port = rss.channel.cloud.port.to_s if defined? rss.channel.cloud.port
      feed.cloud_path = rss.channel.cloud.path.to_s if defined? rss.channel.cloud.path
      feed.cloud_register_Procedure = rss.channel.cloud.registerProcedure.to_s if defined? rss.channel.cloud.registerProcedure
      feed.cloud_protocol = rss.channel.cloud.protocol.to_s if defined? rss.channel.cloud.protocol
      feed.ttl = rss.channel.ttl.to_s
      feed.image_url = rss.channel.image.url.to_s if defined? rss.channel.image.url
      feed.image_title = rss.channel.image.title.to_s if defined? rss.channel.image.title
      feed.image_link = rss.channel.image.link.to_s if defined? rss.channel.image.link
      feed.image_width = rss.channel.image.width.to_s if defined? rss.channel.image.width
      feed.image_height = rss.channel.image.height.to_s if defined? rss.channel.image.height
      feed.rating = rss.channel.rating.to_s
      feed.text_input_title = rss.channel.textInput.title.to_s if defined? rss.channel.textInput.title
      feed.text_input_description = rss.channel.textInput.description.to_s if defined? rss.channel.textInput.description
      feed.text_input_name = rss.channel.textInput.name.to_s if defined? rss.channel.textInput.name
      feed.text_input_link = rss.channel.textInput.link.to_s if defined? rss.channel.textInput.link
      feed.skip_hours_hour = rss.channel.skipHours.hours.to_s if defined? rss.channel.skipHours.hours
      feed.skip_days_day = rss.channel.skipDays.days.to_s if defined? rss.channel.skipDays.days

      RSSnews.news(rss.items, feed.id) if feed.save!

      p rss.channel.title.to_s+'    - Ok'

    end

  end

end

RSSfeed.feeds