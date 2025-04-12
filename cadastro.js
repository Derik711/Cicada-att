 // Elementos do DOM
 const candidatoRadio = document.getElementById('candidato');
 const empresaRadio = document.getElementById('empresa');
 const labelDocumento = document.getElementById('labelDocumento');
 const inputDocumento = document.getElementById('documento');
 const helpDocumento = document.getElementById('helpDocumento');
 
 // Máscaras
 function aplicarMascaraCPF(valor) {
     valor = valor.replace(/\D/g, '');
     
     if (valor.length > 3) {
         valor = valor.substring(0, 3) + '.' + valor.substring(3);
     }
     if (valor.length > 7) {
         valor = valor.substring(0, 7) + '.' + valor.substring(7);
     }
     if (valor.length > 11) {
         valor = valor.substring(0, 11) + '-' + valor.substring(11, 13);
     }
     
     return valor;
 }
 
 function aplicarMascaraCNPJ(valor) {
     valor = valor.replace(/\D/g, '');
     
     if (valor.length > 2) {
         valor = valor.substring(0, 2) + '.' + valor.substring(2);
     }
     if (valor.length > 6) {
         valor = valor.substring(0, 6) + '.' + valor.substring(6);
     }
     if (valor.length > 10) {
         valor = valor.substring(0, 10) + '/' + valor.substring(10);
     }
     if (valor.length > 15) {
         valor = valor.substring(0, 15) + '-' + valor.substring(15, 17);
     }
     
     return valor;
 }
 
 // Evento para mudar entre CPF e CNPJ
 function atualizarTipoDocumento() {
     if (empresaRadio.checked) {
         labelDocumento.textContent = 'CNPJ *';
         inputDocumento.placeholder = '00.000.000/0000-00';
         helpDocumento.textContent = 'Informe o CNPJ da empresa';
         inputDocumento.value = '';
         inputDocumento.maxLength = 18;
     } else {
         labelDocumento.textContent = 'CPF *';
         inputDocumento.placeholder = '000.000.000-00';
         helpDocumento.textContent = 'Informe seu CPF';
         inputDocumento.value = '';
         inputDocumento.maxLength = 14;
     }
 }
 
 // Aplicar máscara conforme digitação
 inputDocumento.addEventListener('input', function(e) {
     if (empresaRadio.checked) {
         e.target.value = aplicarMascaraCNPJ(e.target.value);
     } else {
         e.target.value = aplicarMascaraCPF(e.target.value);
     }
 });
 
 // Ouvintes de evento para os radio buttons
 candidatoRadio.addEventListener('change', atualizarTipoDocumento);
 empresaRadio.addEventListener('change', atualizarTipoDocumento);
 
 // Validação do formulário
 document.getElementById('formCadastro').addEventListener('submit', function(e) {
     if (document.getElementById('senha').value !== 
         document.getElementById('confirmarSenha').value) {
         alert('As senhas não coincidem!');
         e.preventDefault();
     }
     
     // Aqui você pode adicionar mais validações conforme necessário
 });