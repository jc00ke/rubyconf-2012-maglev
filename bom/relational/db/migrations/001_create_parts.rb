Sequel.migration do
  change do
    create_table :parts do
      primary_key :id

      String :part_number
      String :name
      Text :description
      Integer :cost, default: 0
      Integer :count, default: 0
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
