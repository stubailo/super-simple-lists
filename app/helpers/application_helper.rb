module ApplicationHelper
  def init_markdown
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :no_intra_emphasis => true, :tables => true, :autolink => true, :lax_spacing => true, :superscript => true)
  end
end
