  // Contador para requisitos e diferenciais
  let contadorRequisitos = 1;
  let contadorDiferenciais = 1;
  
  // Função para adicionar campo de requisito
  function adicionarRequisito() {
      contadorRequisitos++;
      const novoRequisito = `
          <div class="d-flex mb-2" id="requisito-${contadorRequisitos}">
              <input type="text" class="form-control requisito-input" placeholder="Ex: Conhecimento em JavaScript">
              <button type="button" class="btn btn-outline-danger ms-2" onclick="removerCampo('requisito-${contadorRequisitos}')">
                  <i class="bi bi-trash"></i>
              </button>
          </div>
      `;
      document.getElementById('requisitosContainer').insertAdjacentHTML('beforeend', novoRequisito);
  }
  
  // Função para adicionar campo de diferencial
  function adicionarDiferencial() {
      contadorDiferenciais++;
      const novoDiferencial = `
          <div class="d-flex mb-2" id="diferencial-${contadorDiferenciais}">
              <input type="text" class="form-control diferencial-input" placeholder="Ex: Experiência com React">
              <button type="button" class="btn btn-outline-danger ms-2" onclick="removerCampo('diferencial-${contadorDiferenciais}')">
                  <i class="bi bi-trash"></i>
              </button>
          </div>
      `;
      document.getElementById('diferenciaisContainer').insertAdjacentHTML('beforeend', novoDiferencial);
  }
  
  // Função para remover campo
  function removerCampo(id) {
      document.getElementById(id).remove();
  }
  
  // Validação do formulário
  document.getElementById('formVaga').addEventListener('submit', function(e) {
      e.preventDefault();
      
      // Verificar se há pelo menos um requisito preenchido
      const requisitos = document.querySelectorAll('.requisito-input');
      let requisitosPreenchidos = false;
      
      requisitos.forEach(input => {
          if (input.value.trim() !== '') {
              requisitosPreenchidos = true;
          }
      });
      
      if (!requisitosPreenchidos) {
          alert('Por favor, adicione pelo menos um requisito obrigatório.');
          return;
      }
      
      // Se tudo estiver válido, pode enviar o formulário
      alert('Vaga publicada com sucesso!');
      // Aqui você adicionaria o código para enviar os dados para o servidor
      // this.submit();
  });