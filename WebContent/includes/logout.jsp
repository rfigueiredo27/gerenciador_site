<%
try {
  session.invalidate();
  out.println("sucesso");
}
catch (Exception ex){
  out.println(ex.getMessage());
}
%>
