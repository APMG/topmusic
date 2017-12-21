# frozen_string_literal: true

module SafeImageHelper
  def image_exists?(img)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? img
    else
      Rails.application.assets_manifest.assets[img].present?
    end
  end

  def safe_image_url(img)
    image_url(img) if image_exists?(img)
  end
end
