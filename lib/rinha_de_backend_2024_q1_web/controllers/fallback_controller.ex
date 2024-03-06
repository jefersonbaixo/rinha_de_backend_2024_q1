defmodule RinhaDeBackend2024Q1Web.FallbackController do
  use RinhaDeBackend2024Q1Web, :controller
  alias RinhaDeBackend2024Q1Web.ErrorJSON

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :limit_exceeded}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ErrorJSON)
    |> render(:error, message: :limit_exceeded)
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ErrorJSON)
    |> render(:error, message: message)
  end
end
