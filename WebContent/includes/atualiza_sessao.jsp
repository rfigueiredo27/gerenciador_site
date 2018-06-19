<%
try {
 long novaSessao = java.util.Calendar.getInstance().getTimeInMillis();
  out.println("sucesso");
}
catch (Exception ex){
  out.println(ex.getMessage());
}
%>
