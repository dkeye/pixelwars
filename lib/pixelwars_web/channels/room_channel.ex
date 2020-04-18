defmodule PixelwarsWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    state = Start.State.get_all()
            |> Enum.map(
                 &Tuple.to_list(&1)
                  |> Enum.join(";")
               )
    push(socket, "start", %{"body" => state})
    {:noreply, socket}
  end

  def handle_in("drawed_pixel", %{"body" => body}, socket) do
    [x, y, color] = body
                    |> String.split(";")
    coords = x <>";"<> y
    Start.State.put(coords, color)
    broadcast!(socket, "drawed_pixel", %{"body" => body})
    {:noreply, socket}
  end
end
