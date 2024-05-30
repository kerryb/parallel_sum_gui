defmodule ParallelSumGuiWeb.HomeLiveTest do
  use ParallelSumGuiWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias ParallelSum.Counter
  alias ParallelSum.Total

  describe "ParallelSumGuiWeb.HomeLive" do
    setup do
      Counter.reset()
      Total.reset()
    end

    test "shows the current total", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")
      assert view |> element("#total", "0") |> has_element?()
    end

    test "allows the counter to be run", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")
      view |> element("form") |> render_submit(%{"tasks" => "100"})
      assert view |> element("#total", "500500") |> eventually_has_element?()
    end

    test "allows the counter and total to be reset", %{conn: conn} do
      Counter.value()
      Total.add(42)
      {:ok, view, _html} = live(conn, ~p"/")
      assert view |> element("#total", "42") |> has_element?()
      view |> element("#reset") |> render_click()
      assert Counter.value() == 1
      assert Total.value() == 0
      assert view |> element("#total", "0") |> has_element?()
    end
  end

  defp eventually_has_element?(element, retries \\ 0)
  defp eventually_has_element?(_element, 200), do: false

  defp eventually_has_element?(element, retries) do
    if has_element?(element) do
      true
    else
      Process.sleep(100)
      eventually_has_element?(element, retries + 1)
    end
  end
end
