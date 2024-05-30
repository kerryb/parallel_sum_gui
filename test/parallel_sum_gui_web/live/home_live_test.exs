defmodule ParallelSumGuiWeb.HomeLiveTest do
  use ParallelSumGuiWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "ParallelSumGuiWeb.HomeLive" do
    test "shows the current total", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")
      assert view |> element("#total", "0") |> has_element?()
    end
  end
end
