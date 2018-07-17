module ApplicationHelper
	@@markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
    autolink: true,
    space_after_headers: true,
    no_intra_emphasis: true,
    fenced_code_blocks: true,
    tables: true,
    hard_wrap: true,
    lax_html_blocks: true,
    strikethorough: true
 
  def markdown(text)
    @@markdown.render(text).html_safe
  end
end
