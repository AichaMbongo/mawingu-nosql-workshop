// Load users from CSV
LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
CREATE (:User {
  name: row.name,
  email: row.email,
  title: row.title, 
  location: row.location,
  experience_years: toInteger(row.experience_years),
  created_at: datetime()
});

// Load companies from CSV
LOAD CSV WITH HEADERS FROM 'file:///companies.csv' AS row
CREATE (:Company {
  name: row.name,
  industry: row.industry,
  location: row.location,
  size: row.size,
  founded: toInteger(row.founded)
});
