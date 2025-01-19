module RecipesHelper

    def display_content(content)
        parsed_content = JSON.parse(content)
        content_html = parsed_content['blocks'].map do |block|
            case block['type']
            when 'paragraph'
                "<p>#{block['data']['text']}</p>"
            when 'header'
                "<h#{block['data']['level']} class='title is-5'>#{block['data']['text']}</h#{block['data']['level']}>"
            when 'list'
                list_items = block['data']['items'].map{
                    |item|
                    "<li>#{item['content']}</li>"
                }.join
                case block['data']['style']
                when 'unordered'
                    "<ul>#{list_items}</ul>"
                when 'ordered'
                    "<ol>#{list_items}</ol>"
                end
            else
                ''
            end
        end
        content_html.join.html_safe
    end
end
