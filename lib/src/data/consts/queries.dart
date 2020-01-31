String getCharacters(int page) => """
query {
  characters(page: $page) {
    info {
      count,
      pages
    }
    results {
      id,
      name,
      status,
      species,
      type,
      gender,
      origin {
        name
      }
      location {
        name
      }
      image,      
    }
  }
} 
""";