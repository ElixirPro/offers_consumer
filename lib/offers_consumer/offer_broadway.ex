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
        big_discount: [concurrency: 2, batch_size: 10],
        discount: [concurrency: 1, batch_size: 10]
      ]
    )
  end

  def handle_message(_, %Message{data: data} = message, _) do
    payload =
      data
      |> Jason.decode!()

    if payload["discount"] >= 50 do
      message
      |> Message.put_batcher(:big_discount)
    else
      message
      |> Message.put_batcher(:discount)
    end

    # |> Message.update_data(&process_data/1)
    # |> Message.put_batcher(:sqs)

    # |> Message.update_data(&process_data/1)
    # |> Message.put_batcher(:s3)
  end

  def handle_batch(:big_discount, messages, _batch_info, _context) do
    messages
    |> Enum.map(& &1.data |> Jason.decode!())
    |> IO.inspect()
    messages
  end

  def handle_batch(:discount, messages, _batch_info, _context) do
    messages
    |> Enum.map(& &1.data |> Jason.decode!())
    |> IO.inspect()
    messages
  end
end
