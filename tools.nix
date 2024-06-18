# Random helper functions
{
  # Reference a user secret that agenix will decrypt using the host key
  userSecret = fileName: {
    "${fileName}" = {
      file = secrets/${fileName}.age;
      owner = "kamek";
    };
  };
}
