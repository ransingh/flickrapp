module PhotoHelper
  def photo_list(photos)
    content_tag(:div, :class => 'container-fluid') do
      photos.map do |photo|
        photo_container(photo)
      end.reduce(:<<)
    end
  end

  def photo_container(photo)
    link_to(photo_url(photo.id), :remote => true) do
      content_row("border-bottom: 1px #ddd solid;margin-bottom: 8px;") do
        content_column("col-sm-12") do
          photo_row(photo)
        end
      end
    end
  end

  def photo_row(photo)
    content_row do
      inner = content_column("col-xs-2 .col-sm-6") do
        image_tag(photo.thumbnail_url)
      end
      inner << content_column("col-xs-10 .col-sm-6") do
        # link_to('Show Original', photo_url(photo.id), remote: true)
        content_tag(:h5, photo.title)
      end
    end
  end
end