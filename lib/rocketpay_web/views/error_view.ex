defmodule RocketpayWeb.ErrorView do
  use RocketpayWeb, :view

  alias Ecto.Changeset

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("400.json",%{result: %Changeset{} = changeset})do
    %{message: translate_errors(changeset)}
  end

  def render("400.json",%{result: message})do
    %{message: message}
  end

  defp translate_errors(changeset) do
    Changeset.traverse_errors(changeset, fn{msg,opts} ->
      Enum.reduce(opts,msg,fn{key,value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
