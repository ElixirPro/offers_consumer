defmodule OfferBroadway do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: "offers_consumers",
             topics: ["ofertas"]
           ]},
        concurrency: 10
      ],
      processors: [
        default: [
          concurrency: 2
        ]
      ],
      batchers: [
        default: [
          offer_odd: [concurrency: 2, batch_size: 10],
          offer_even: [concurrency: 1, batch_size: 10]
        ]
      ]
    )
  end

  def handle_message(_, %Message{data: data} = message, _) when is_odd(data) do
    message
    |> IO.inspect()

    # |> Message.update_data(&process_data/1)
    # |> Message.put_batcher(:sqs)
  end

  def handle_message(_, %Message{data: data} = message, _) when is_even(data) do
    message
    |> IO.inspect()

    # |> Message.update_data(&process_data/1)
    # |> Message.put_batcher(:s3)
  end

  defp process_data(data) do
    # Do some calculations, generate a JSON representation, etc.
  end
end
