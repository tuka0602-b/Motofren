module NavbarSupport
  def click_dropdown
    find(".navbar-toggler").click
    click_link "Dropdown"
  end
end
