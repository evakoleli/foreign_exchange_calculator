module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /^the home page$/
      root_path
    when /^the result page$/
      result_path
    end
  end
end
World(NavigationHelpers)
