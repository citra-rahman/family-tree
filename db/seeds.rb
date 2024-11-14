ActiveRecord::Base.transaction do
  arthur_family = Family.create!(name: "The King Arthur Family")

  members = [
    {
      name: "king arthur",
      gender: "male",
      birth_date: "1930-01-01 00:00:00 UTC",
      death_date: "2000-12-01 15:35:00 UTC",
      family_id: arthur_family.id
    },
    {
      name: "queen margareth",
      gender: "female",
      birth_date: "1930-01-13 00:00:00 UTC",
      death_date: "2002-05-01 13:00:00 UTC",
      family_id: arthur_family.id
    },
    {
      name: "bill",
      gender: "male",
      birth_date: "1950-03-16 13:00:00 UTC",
      death_date: nil,
      family_id: arthur_family.id
    },
    {
      name: "charlie",
      gender: "male",
      birth_date: "1952-01-17 16:00:00 UTC",
      death_date: nil,
      family_id: arthur_family.id
    },
    {
      name: "percie",
      gender: "male",
      birth_date: "1953-03-24 00:00:00 UTC",
      death_date: nil,
      family_id: arthur_family.id
    },
    {
      name: "ronald",
      gender: "male",
      birth_date: "1955-12-01 00:00:00 UTC",
      death_date: nil,
      family_id: arthur_family.id
    },
    {
      name: "ginerva",
      gender: "female",
      birth_date: "1960-07-13 00:00:00 UTC",
      death_date: nil,
      family_id: arthur_family.id
    },
    {
      name: "flora",
      gender: "female",
      birth_date: "1954-01-13 00:00:00 UTC",
      death_date: nil,
      family_id: arthur_family.id
    }
  ]
  members.map { |m| Member.create(m) }

  relationships = [
    {
      member1_id: 1,
      member2_id: 2,
      types: "spouse"
    },
    {
      member1_id: 3,
      member2_id: 2,
      types: "child"
    },
    {
      member1_id: 4,
      member2_id: 2,
      types: "child"
    },
    {
      member1_id: 5,
      member2_id: 2,
      types: "child"
    },
    {
      member1_id: 6,
      member2_id: 2,
      types: "child"
    },
    {
      member1_id: 7,
      member2_id: 2,
      types: "child"
    },
    {
      member1_id: 3,
      member2_id: 8,
      types: "spouse"
    }
  ]
  relationships.map { |r| Relationship.create(r) }
end
