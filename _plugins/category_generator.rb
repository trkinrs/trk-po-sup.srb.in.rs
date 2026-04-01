module Jekyll
  class CategoryPage < Page
    def initialize(site, base, dir, category_name, title)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"

      process(@name)
      read_yaml(File.join(base, "_layouts"), "category.html")

      data["category"] = category_name
      data["title"] = title
    end
  end

  class CategoryGenerator < Generator
    safe true
    priority :low

    def generate(site)
      return unless site.layouts.key?("category")

      categories = normalize_categories(site)
      categories.each do |cat|
        dir = File.join("categories", cat[:slug])
        site.pages << CategoryPage.new(site, site.source, dir, cat[:name], cat[:title])
      end
    end

    private

    def normalize_categories(site)
      data = site.data["categories"]
      from_data = []

      if data.is_a?(Array)
        data.each do |entry|
          if entry.is_a?(String)
            from_data << {name: entry, title: entry, slug: Utils.slugify(entry)}
          elsif entry.is_a?(Hash)
            name = entry["name"] || entry[:name]
            next if name.nil? || name.to_s.strip.empty?

            title = entry["title"] || entry[:title] || name
            slug = entry["slug"] || entry[:slug] || Utils.slugify(name.to_s)
            from_data << {name: name.to_s, title: title.to_s, slug: slug.to_s}
          end
        end
      end

      # Ensure every category used by posts has a page, too.
      existing_names = from_data.map { |c| c[:name] }
      site.categories.keys.each do |name|
        next if existing_names.include?(name)
        from_data << {name: name, title: name, slug: Utils.slugify(name.to_s)}
      end

      # Deduplicate by slug (last one wins).
      by_slug = {}
      from_data.each { |c| by_slug[c[:slug]] = c }
      by_slug.values
    end
  end
end
