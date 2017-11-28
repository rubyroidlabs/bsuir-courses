module BootstrapPaginationHelper
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
    protected

      def page_number(page)
        if page == current_page
          link(page, "#", :class => 'active')
        else
          link(page, page, :rel => rel_value(page))
        end
      end

      def gap
        text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
        %(<li class="page-item disabled"><a>#{text}</a></li>)
      end

      def next_page
        num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
        previous_or_next_page(num, @options[:next_label], 'next')
      end

      def previous_page
        num = (@collection.current_page - 1 > 0) && @collection.current_page - 1
        previous_or_next_page(num, @options[:previous_label], 'previous')
      end

      def previous_or_next_page(page, text, classname)
        if page
          link(text, page, :class => classname)
        else
          link(text, "#", :class => classname + ' disabled')
        end
      end

      def html_container(html)
        tag(:nav, tag(:ul, html), container_attributes)
      end

    private

    def link(text, target, attributes = {})
      if target.is_a? Fixnum
        attributes[:rel] = rel_value(target)
        target = url(target)
      end

      unless target == "#"
        attributes[:href] = target
      end

      attributes[:class] ||= ''
      classname = attributes[:class]
      attributes[:class] += ' page-link'
      tag(:li, tag(:a, text, attributes), :class => classname + ' page-item')
    end
  end
end
