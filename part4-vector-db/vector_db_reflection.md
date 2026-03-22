## Vector DB Use Case

A traditional keyword-based search would fall short for a law firm searching 500-page contracts in plain English, and here's why.

Keyword search matches exact strings. If a lawyer asks "What are the termination clauses?" the system looks for the word "termination." But contracts often say things like "early exit provision," "notice of dissolution," or "right to cancel upon breach." None of those match the keyword, so the search returns nothing — even though the clause is right there. Conversely, the word "termination" might appear dozens of times in unrelated sections (termination of liability, termination of warranty), flooding results with noise.

This is exactly the problem a vector database solves. The system would work in three steps. First, each contract is split into overlapping chunks of a few hundred words. Second, each chunk is converted into a high-dimensional embedding vector using a language model like `all-MiniLM-L6-v2` or OpenAI's embedding API. These vectors encode *meaning*, not just words — chunks about ending a contract cluster together in vector space regardless of the specific words used. Third, these vectors are stored in a vector database like Pinecone, Weaviate, or ChromaDB.

When a lawyer types "What are the termination clauses?", that query is also embedded into a vector. The database then finds the stored chunks whose vectors are closest to the query vector — returning semantically relevant passages even if the wording is completely different.

For a law firm, missing a termination clause in a 500-page contract could mean losing a case or a client. Keyword search is too brittle for that kind of precision requirement. A vector database makes the search understand intent, not just text.
