#encoding: utf-8
require 'rss'
require 'sanitize'

namespace :fn do

  desc 'Atualizar banco (ler tabela de Feed para carregar novas news)'
  task :news => :environment do

    p 'Atualizando banco'

    feeds = Feed.all()

    feeds.each do |feed|

      begin
        rss = RSS::Parser.parse(open(feed.rss_link).read, false)
      rescue => error
        p error
        next
      end

      if defined? rss.items
        rss.items.each do |it|

          feedNews = feed.news
          if !feedNews.blank? && !it.link.blank? && feedNews.exists?(link: it.link.to_s) && feedNews.exists?(title: it.title.to_s)
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
          @news.feed_id = feed.id

          @news.save!

        end

        p feed.link

      end

    end

  end

  desc 'Deleta (limita 200 news por feed e deleta news gravadas a mais de 15 dias)'
  task :limit => :environment do
    puts 'Delete news de feeds acima de 200 row-------------------'
    Feed.all.each do |feed|
      puts feed.title
      puts News.delete(feed.news.offset(200))
      puts '--------------------------------'
    end
    puts 'Delete news salvas mais de 15 dias -------------------'
    puts News.delete_all(["updated_at < ?", Time.now - 15.days])
  end

  desc 'teste'
  task :test => :environment do
    p 'teste'
  end

end