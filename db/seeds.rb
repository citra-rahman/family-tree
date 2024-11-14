ActiveRecord::Base.transaction do
  arthur_family = Family.create!(name: "The King Arthur Family")
  family_2 = Family.create!(name: "Family 2")

  members = [
    {
      name: "King Arthur",
      gender: "male",
      birth_date: "1930-01-01 00:00:00 UTC",
      death_date: "2000-12-01 15:35:00 UTC",
      family_id: arthur_family[:id]
    },
    {
      name: "Queen margareth",
      gender: "female",
      birth_date: "1930-01-13 00:00:00 UTC",
      death_date: "2002-05-01 13:00:00 UTC",
      family_id: arthur_family[:id]
    },
    {
      name: "Bill",
      gender: "male",
      birth_date: "1950-03-16 13:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Charlie",
      gender: "male",
      birth_date: "1952-01-17 16:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Percy",
      gender: "male",
      birth_date: "1953-03-24 00:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Ronald",
      gender: "male",
      birth_date: "1955-12-01 00:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Ginerva",
      gender: "female",
      birth_date: "1960-07-13 00:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Flora",
      gender: "female",
      birth_date: "1954-01-13 00:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Audrey",
      gender: "female",
      birth_date: "1955-05-01 18:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Helen",
      gender: "female",
      birth_date: "1955-12-13 13:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Harry",
      gender: "male",
      birth_date: "1958-03-15 10:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Victoire",
      gender: "female",
      birth_date: "1970-05-12 10:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Dominique",
      gender: "female",
      birth_date: "1972-06-17 10:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Louis",
      gender: "male",
      birth_date: "1975-09-22 10:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Ted",
      gender: "male",
      birth_date: "1969-08-26 10:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    },
    {
      name: "Remus",
      gender: "male",
      birth_date: "1969-08-26 10:00:00 UTC",
      death_date: nil,
      family_id: arthur_family[:id]
    }
  ]
  members = members.map! { |m| Member.create!(m) }

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
    },
    {
      member1_id: 5,
      member2_id: 9,
      types: "spouse"
    },
    {
      member1_id: 6,
      member2_id: 10,
      types: "spouse"
    },
    {
      member1_id: 11,
      member2_id: 7,
      types: "spouse"
    },
    {
      member1_id: 12,
      member2_id: 8,
      types: "child"
    },
    {
      member1_id: 13,
      member2_id: 8,
      types: "child"
    },
    {
      member1_id: 14,
      member2_id: 8,
      types: "child"
    },
    {
      member1_id: 15,
      member2_id: 12,
      types: "spouse"
    },
    {
      member1_id: 16,
      member2_id: 12,
      types: "child"
    }
  ]
  relationships.map { |r| Relationship.create(r) }
end
