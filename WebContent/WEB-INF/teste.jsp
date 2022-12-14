<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>

<!-- Toastr -->
<link rel="stylesheet" href="${pageContext.servletConfig.servletContext.contextPath}/plugins/toastr/toastr.min.css">
<script src="${pageContext.servletConfig.servletContext.contextPath}/plugins/toastr/toastr.min.js"></script>

<script src="${pageContext.servletConfig.servletContext.contextPath}/plugins/jquery/jquery.min.js"></script>

<title>Insert title here</title>
</head>
<body>

<script>
toastr.success('Lorem ipsum dolor sit amet, consetetur sadipscing elitr.')
</script>

</body>
</html>