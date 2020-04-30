defmodule PixelwarsWeb.PageController do
  use PixelwarsWeb, :controller

  def index(conn, _params) do
    render(conn, :mp)
  end
end
