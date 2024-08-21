{ system }:

{
  polykey-cli = (
    builtins.getFlake "github:MatrixAI/Polykey-CLI/41d6dd0c7ea1bbdfe759a6085c537a559bcd5cb2"
  ).packages.${system}.default;  
}
