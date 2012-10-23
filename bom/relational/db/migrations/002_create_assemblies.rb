Sequel.migration do
  change do
    create_table :assemblies do
      primary_key :id

      String :parent_part_number
      Integer :sequence, default: 0
      Integer :quantity, default: 0
      Integer :level, default: 0
      Integer :part_id
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
