module ApplicationHelper

def get_bread_crumb(url)
  begin
    breadcrumb = ''
    sofar = '/'
    elements = url.split('/')
    breadcrumb += "<a href=/>Strona Glowna</a> / "
    for i in 1...elements.size
      sofar += elements[i] + '/'
      if i%2 == 0
        begin
          breadcrumb += "<a href='#{sofar}'>"  + eval("#{elements[i - 1].singularize.camelize}.find(#{elements[i]}).name").to_s + '</a>'
        rescue
          breadcrumb += elements[i]
        end
      else
        breadcrumb += "<a href='#{sofar}'>#{elements[i].pluralize}</a>"
      end
      breadcrumb += ' / ' if i != elements.size - 1
    end
    breadcrumb = breadcrumb.html_safe
  rescue
    'Not available'
  end
end
end
