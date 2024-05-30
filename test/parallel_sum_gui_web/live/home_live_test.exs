defmodule ParallelSumGuiWeb.HomeLiveTest do
  use ParallelSumGuiWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias ParallelSum.Total

  describe "ParallelSumGuiWeb.HomeLive" do
    setup do
      Total.reset()
    end

    test "shows the current total", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")
      assert view |> element("#total", "0") |> has_element?()
    end

    test "allows the total to be reset", %{conn: conn} do
      Total.add(42)
      {:ok, view, _html} = live(conn, ~p"/")
      assert view |> element("#total", "42") |> has_element?()
      view |> element("#reset") |> render_click()
      assert view |> element("#total", "0") |> has_element?()
    end
  end
end
