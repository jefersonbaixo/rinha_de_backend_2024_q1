defmodule RinhaDeBackend2024Q1Web.FallbackController do
  use RinhaDeBackend2024Q1Web, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: RinhaDeBackend2024Q1Web.ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: RinhaDeBackend2024Q1Web.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: RinhaDeBackend2024Q1Web.ErrorJSON)
    |> render(:error, message: message)
  end
end
