defmodule Practica do
@moduledoc """
  Este modulo implementa un CRUD, con un id automatico usando una estructura
"""

  defstruct id: 1, entradas: %{}

  @doc """
    Crea una estructura nueva
  """
  def nuevo do
    %Practica{}
  end

  @doc """
    Agrega una entrada
  """
  def agregar_entrada(
      %Practica{id: id, entradas: entradas} = lista,
      entrada
    ) do
    nueva_entrada = Map.put(entrada, :id, id)
    nuevas_entradas = Map.put(entradas, id, nueva_entrada)

    %Practica{
      lista |
      entradas: nuevas_entradas,
      id: id + 1
    }
  end

  @doc """
    Muestra las entradas de acuerdo a la fecha ingresada
  """
  def mostrar(%Practica{entradas: entradas}, fecha) do
    entradas
    |> Stream.filter(fn({ _, entrada}) ->
        entrada.fecha == fecha
      end
      )

    |> Enum.map(fn({_, entrada}) ->
        entrada
      end
      )
  end

  @doc """
    Modifica la entrada de acuerdo al id
  """

  def modificar(lista, %{} = nueva_entrada  ) do
    modificar(lista,nueva_entrada.id, fn(_) -> nueva_entrada end)
  end

  def modificar(
    %Practica{entradas: entradas} = lista,
    id,
    funcion_modificar
  ) do
    case entradas[id] do
      nil -> entradas

      vieja_entrada ->
        nueva_entrada = funcion_modificar.(vieja_entrada)
        nuevas_entradas = Map.put(entradas, nueva_entrada.id, nueva_entrada)
        %Practica{ lista | entradas: nuevas_entradas }
    end
  end

  @doc """
    Borrar entrada de acuerdo al id
  """
  def borrar(
    %Practica{entradas: entradas} = lista,
    id
    ) do
      %Practica{ lista | entradas: Map.delete(entradas, id)}
  end

end
