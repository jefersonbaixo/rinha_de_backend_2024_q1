defmodule RinhaDeBackend2024Q1Web.ErrorJSONTest do
  use RinhaDeBackend2024Q1Web.ConnCase, async: true

  test "renders 404" do
    assert RinhaDeBackend2024Q1Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert RinhaDeBackend2024Q1Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
