Sequel.migration do
  change do
    create_table :assemblies_parts do
      Integer :assembly_id
      Integer :part_id
    end
  end
end
