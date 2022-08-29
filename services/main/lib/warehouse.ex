defmodule MainWeb.Warehouse do
  alias Req

  def reserve_stock() do
    Req.get!("smgasa")
  end
end
