# Manual Visual do Usuário - BlackB0x Linux 1.0

## Distribuição Linux Focada em Privacidade e Segurança

---

**Versão:** 1.0 "Terminal"  
**Data:** Dezembro 2024  
**Website:** https://blackb0x.com.br  

---

## Sumário

1. [Introdução](#introdução)
2. [Características Principais](#características-principais)
3. [Processo de Boot](#processo-de-boot)
4. [Interface do Sistema](#interface-do-sistema)
5. [Navegação Segura](#navegação-segura)
6. [Terminal e Comandos](#terminal-e-comandos)
7. [Segurança e Criptografia](#segurança-e-criptografia)
8. [Solução de Problemas](#solução-de-problemas)

---

## Introdução

O **BlackB0x Linux** é uma distribuição especializada focada em privacidade e segurança, baseada em conceitos do TailOS. Foi desenvolvida para usuários que necessitam de um ambiente seguro e anônimo para suas atividades digitais.

### Principais Diferenciais

- **Criptografia LUKS** para proteção total do sistema de arquivos
- **Sistema F2FS** otimizado para performance e segurança
- **Tor Browser** com inicialização automática
- **Interface XFCE** leve e eficiente
- **Localização completa** em português brasileiro
- **Boot compatível** com BIOS legacy e UEFI

---

## Características Principais

### 🔒 **Segurança Avançada**
- Criptografia de disco completa com LUKS
- Navegação anônima via rede Tor
- Sistemas temporários em RAM (tmpfs)
- Sem logs persistentes

### 💾 **Sistema de Arquivos Otimizado**
- F2FS como sistema principal
- ZRAM para swap em memória
- Estrutura otimizada para SSDs

### 🌍 **Localização Brasileira**
- Interface em português brasileiro
- Timezone São Paulo (-3:00)
- Layout de teclado ABNT2
- Formatos de data e moeda nacionais

### ⚡ **Performance**
- Boot rápido e eficiente
- Consumo otimizado de recursos
- Interface responsiva

---


## Processo de Boot

### 1. Tela de Boot GRUB

Ao inicializar o sistema, você será apresentado à tela de boot do GRUB com o tema personalizado BlackB0x.

![Tela de Boot GRUB](https://private-us-east-1.manuscdn.com/sessionFile/SfmArUnFHHSVKPhg3WUxDi/sandbox/FpjJwWdUgbqiFa7JWW9RdW-images_1749036346331_na1fn_L2hvbWUvdWJ1bnR1L2JsYWNrYjB4X3NjcmVlbnNob3RzLzAxX2dydWJfYm9vdA.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvU2ZtQXJVbkZISFNWS1BoZzNXVXhEaS9zYW5kYm94L0Zwakp3V2RVZ2JxaUZhN0pXVzlSZFctaW1hZ2VzXzE3NDkwMzYzNDYzMzFfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwySnNZV05yWWpCNFgzTmpjbVZsYm5Ob2IzUnpMekF4WDJkeWRXSmZZbTl2ZEEucG5nIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzY3MjI1NjAwfX19XX0_&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=m0vTVt-Xol0~I6811ptbNwWwG9~OypaJ-rRxO~xCLkLP0hMz16wmZukOtF5Tx6crhJEiqDJrRQuHRxhw1yruetxRG3yqPQ469sbJIfMImI9dppyBwKhRYlRhq1K1bteXL~kORwdnp7oDlbqGeLnekYeHWPyJSxbdulzORi-AxnMJOFB5BqFQEyGqjLLO38urvvYwHqkJgdRYlIKSwu0MrVaQoqX9wZSygObLy-MnaL~GQCdvhvz70MlOMblARFCjQjDA5~yIHzw86zBWO8wvwLYJ8ZvzzzweVXK3QA5hjGWADWeSee48wGOIn3v2GOhvb19BEZ0bRBQnwmQkv7N8kA__)

**Opções disponíveis:**
- **BlackB0x Linux 1.0 (Terminal)** - Boot padrão
- **BlackB0x Linux 1.0 (Modo Seguro)** - Para hardware com problemas
- **BlackB0x Linux 1.0 (Modo de Recuperação)** - Para manutenção
- **Verificar Mídia** - Teste de integridade
- **Boot do Disco Rígido** - Boot do sistema instalado

**Instruções:**
- Use as setas ↑↓ para navegar
- Pressione Enter para selecionar
- O sistema inicia automaticamente em 5 segundos

### 2. Desbloqueio LUKS (Se Aplicável)

Se você instalou o sistema com criptografia LUKS, será solicitada a senha de desbloqueio.

![Desbloqueio LUKS](https://private-us-east-1.manuscdn.com/sessionFile/SfmArUnFHHSVKPhg3WUxDi/sandbox/FpjJwWdUgbqiFa7JWW9RdW-images_1749036346331_na1fn_L2hvbWUvdWJ1bnR1L2JsYWNrYjB4X3NjcmVlbnNob3RzLzAyX2x1a3NfcGFzc3dvcmQ.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvU2ZtQXJVbkZISFNWS1BoZzNXVXhEaS9zYW5kYm94L0Zwakp3V2RVZ2JxaUZhN0pXVzlSZFctaW1hZ2VzXzE3NDkwMzYzNDYzMzFfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwySnNZV05yWWpCNFgzTmpjbVZsYm5Ob2IzUnpMekF5WDJ4MWEzTmZjR0Z6YzNkdmNtUS5wbmciLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE3NjcyMjU2MDB9fX1dfQ__&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=iyXNWNAQ60YCGM8UZ4c~pb72PV3Pk56On4l9rNTT~6Wv6QiE4lkn7pwgNnhEuifz1dMZWhfdF587sx3MJCHkQGnS-1xQPgctF~Z5f-CV8N0k0LZRSgYW8uzfiCVO8173XX~JQqfKOH3n5XT0ZoetjnzgWEOzP2wT3cHNIatdcw~N1PIxACi87TslrkTIaVXxfgk308ieHCJr8dJmWviN6csaMc9R5zm2YfQIOUkRgU1M6nGo1qj8priOapKm~2lWewSVHlfGgEFDHEZ9~XJAfdj~s4cQKnYCeblIOhU3kdWTheHXLLsfRCNrA9y4p6lT0OdUfh~HgdibqXX6A56CSg__)

**Processo:**
1. Digite sua senha de criptografia
2. Pressione Enter
3. O sistema desbloqueará automaticamente
4. Em caso de erro, você pode tentar novamente

**⚠️ Importante:** Sem a senha correta, não é possível acessar o sistema.

### 3. Tela de Login LightDM

Após o boot, você verá a tela de login com o tema BlackB0x.

![Login LightDM](https://private-us-east-1.manuscdn.com/sessionFile/SfmArUnFHHSVKPhg3WUxDi/sandbox/FpjJwWdUgbqiFa7JWW9RdW-images_1749036346331_na1fn_L2hvbWUvdWJ1bnR1L2JsYWNrYjB4X3NjcmVlbnNob3RzLzAzX2xpZ2h0ZG1fbG9naW4.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvU2ZtQXJVbkZISFNWS1BoZzNXVXhEaS9zYW5kYm94L0Zwakp3V2RVZ2JxaUZhN0pXVzlSZFctaW1hZ2VzXzE3NDkwMzYzNDYzMzFfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwySnNZV05yWWpCNFgzTmpjbVZsYm5Ob2IzUnpMekF6WDJ4cFoyaDBaRzFmYkc5bmFXNC5wbmciLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE3NjcyMjU2MDB9fX1dfQ__&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=Oux17Rmkv9ZDuGI6bvXG0tu1cUsJVw~VHczxHjfvL9g2fWUxviRZ3nz6nGSHngDsLb0fSRLhWtxsQ7PFEz1mGrQa0MuATqX2gX3ZOEVAgMD-1j83ai0cXFCygvAqf73nUg~Rb5O~LqpCDya0VA0pGdISI5zZsA4ng0Mc2IVCKzE9KlHYxmLM1SHjtbIGN3-vrKHMektMsaeQqdHVxWqKXZQqZrfI~52mqcpd-ZmuKdB6HohwhPQudpvf-8WuJkHyOn2Z5V4rYr0COs4aiKEY-A7Ned5xUpodTanrUHkFWFMthVVjA9sbU~Ihj2VKwngc3Oqy9AbT-tcSKO5GJQ4Pgw__)

**Características:**
- **Usuário padrão:** blackb0x
- **Login automático** habilitado por padrão
- **Papel de parede** personalizado
- **Tema escuro** com elementos verdes

---

## Interface do Sistema

### Desktop XFCE

O BlackB0x utiliza o ambiente XFCE configurado com tema escuro e elementos visuais personalizados.

![Desktop XFCE](https://private-us-east-1.manuscdn.com/sessionFile/SfmArUnFHHSVKPhg3WUxDi/sandbox/FpjJwWdUgbqiFa7JWW9RdW-images_1749036346331_na1fn_L2hvbWUvdWJ1bnR1L2JsYWNrYjB4X3NjcmVlbnNob3RzLzA0X3hmY2VfZGVza3RvcA.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvU2ZtQXJVbkZISFNWS1BoZzNXVXhEaS9zYW5kYm94L0Zwakp3V2RVZ2JxaUZhN0pXVzlSZFctaW1hZ2VzXzE3NDkwMzYzNDYzMzFfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwySnNZV05yWWpCNFgzTmpjbVZsYm5Ob2IzUnpMekEwWDNobVkyVmZaR1Z6YTNSdmNBLnBuZyIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTc2NzIyNTYwMH19fV19&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=FnyJ4ndvtnb1p8RX80bO9tItU~dvId2oRHlO9GnMGF-SuuP~EDxUIWpjmuefs~ItLSCQpematlUbhIZI~2C-BSmg~aVmMwgSDOg3C6yuRa7W6NoN0Q3ZE-IpRWgD8A-iLQrdoIWetbth5xTnTlp6-v3Lc2VUaaIAdN1biNWy839K~dkpInRwr~FnAPxYPMritnNaF6Hr12oaaZjqpKJ92Zz1Udh32qoQ59aMVP2jiyR~p2~HsbRLjjxFqx~8TlNKfg7MklwPn8nJfBYkGPdxlvZgQQlLnNiINJqY~WdQyj0m69Rpu0PXqZiBuRQbQgoDcltfggEtZggnYvuvXVaPMw__)

**Elementos da interface:**
- **Papel de parede** com prompt terminal
- **Painel inferior** com menu e bandeja
- **Ícones na área de trabalho** para acesso rápido
- **Tema escuro** consistente

**Aplicações principais:**
- **Terminal** - Acesso ao sistema
- **Tor Browser** - Navegação segura
- **Gerenciador de Arquivos** - Exploração de diretórios
- **Menu de Aplicações** - Acesso a todos os programas

### Navegação no Sistema

**Atalhos úteis:**
- `Ctrl+Alt+T` - Abrir terminal
- `Alt+F1` - Menu de aplicações
- `Alt+F2` - Executar comando
- `Ctrl+Alt+L` - Bloquear tela

**Diretórios do usuário:**
- `Documentos` - Arquivos pessoais
- `Downloads` - Arquivos baixados
- `Imagens` - Fotos e capturas
- `Área de Trabalho` - Atalhos e arquivos

---


## Navegação Segura

### Tor Browser Automático

O BlackB0x inicia automaticamente o Tor Browser e navega para a página de boas-vindas.

![Tor Browser](https://private-us-east-1.manuscdn.com/sessionFile/SfmArUnFHHSVKPhg3WUxDi/sandbox/FpjJwWdUgbqiFa7JWW9RdW-images_1749036346403_na1fn_L2hvbWUvdWJ1bnR1L2JsYWNrYjB4X3NjcmVlbnNob3RzLzA1X3Rvcl9icm93c2Vy.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvU2ZtQXJVbkZISFNWS1BoZzNXVXhEaS9zYW5kYm94L0Zwakp3V2RVZ2JxaUZhN0pXVzlSZFctaW1hZ2VzXzE3NDkwMzYzNDY0MDNfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwySnNZV05yWWpCNFgzTmpjbVZsYm5Ob2IzUnpMekExWDNSdmNsOWljbTkzYzJWeS5wbmciLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE3NjcyMjU2MDB9fX1dfQ__&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=AcEMRbG0UMh-pUVuO3OHoAutgrEVEpimhAQf~0hZ5JbMMahN3DUET5kKLtM8oIU~Tqc6nGdd2fDyH-GdNi0KIaZBkylG2~UGqWQTAU4CmahjHIdxJorhfnzpjP70CmtrIWR6kMRySsEjCgyrED9Lzd36dE64IWpRWCXst99hHe-yWaogeX7V8qtujAwFAb~enqH8jBrFl9nGuZ7htEDQeHGXmZNjuY1lwKG-D8n1DERWmS6olNWKHr3YcYl4bEQw472pgo3qIO-1pA5pYyoB1mneFWtSKGPidYEz2g6kDZXtfScPiiknFdFzWNawQB0KFyDSKhDTtddm6dV6Plpg7A__)

**Características:**
- **Inicialização automática** após login
- **Navegação para** blackb0x.com.br/BemVindo
- **Conexão via rede Tor** para anonimato
- **Tema escuro** consistente

**Funcionalidades de segurança:**
- Todo tráfego passa pela rede Tor
- Cookies e histórico são limpos automaticamente
- JavaScript pode ser desabilitado para maior segurança
- Proteção contra fingerprinting

**Uso recomendado:**
- Mantenha o Tor Browser sempre atualizado
- Não instale plugins adicionais
- Use apenas sites HTTPS quando possível
- Evite downloads de arquivos suspeitos

### Configurações de Rede

O sistema está configurado para máxima privacidade:
- **DNS sobre Tor** habilitado
- **IPv6 desabilitado** por segurança
- **Randomização de MAC** ativada
- **Firewall restritivo** configurado

---

## Terminal e Comandos

### Interface do Terminal

O terminal XFCE oferece acesso completo ao sistema com tema personalizado.

![Terminal](https://private-us-east-1.manuscdn.com/sessionFile/SfmArUnFHHSVKPhg3WUxDi/sandbox/FpjJwWdUgbqiFa7JWW9RdW-images_1749036346403_na1fn_L2hvbWUvdWJ1bnR1L2JsYWNrYjB4X3NjcmVlbnNob3RzLzA2X3Rlcm1pbmFs.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvU2ZtQXJVbkZISFNWS1BoZzNXVXhEaS9zYW5kYm94L0Zwakp3V2RVZ2JxaUZhN0pXVzlSZFctaW1hZ2VzXzE3NDkwMzYzNDY0MDNfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwySnNZV05yWWpCNFgzTmpjbVZsYm5Ob2IzUnpMekEyWDNSbGNtMXBibUZzLnBuZyIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTc2NzIyNTYwMH19fV19&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=mN339prlihBQIn2mTe7jjCPq1STk3yPefaY--smMHe1S1kXM8XGSeS9j6CjDfeEWffmBnu628lOrDEJ7iopQ4NIzVLkk0fRAoLkJSSQwurPM7YG2IJMUqiWMarMxv~wgMef4GwGnlxQiGX5bOO9HAIuRMXNfg0m-qJw5bCjYGCgtpWXyOR3nVRTPse~4WDsxdUicw8rfb6stv41OHJhOvZE9AJLPXbqs1F5SnWRVJ8ZmCn4rsSuSHpPR20Ht2j-RAYaf6xse3wZkMLFL9FnhkOj~zSs5LOrWxTYViCSsBy~NNKBlvbTXp7ZGkv2C0vJP8OrDR2uCncdH2nhp-0T97Q__)

**Características:**
- **Prompt personalizado:** `blackb0x@BlackB0x:~$`
- **Cores verde terminal** sobre fundo preto
- **Fonte monoespaçada** para melhor legibilidade
- **Histórico de comandos** disponível

### Comandos Essenciais

**Informações do sistema:**
```bash
uname -a                    # Informações do kernel
df -h                       # Uso do disco
free -h                     # Uso da memória
systemctl status tor        # Status do serviço Tor
```

**Gerenciamento de criptografia:**
```bash
cryptsetup status cryptroot # Status da criptografia
lsblk                       # Listar dispositivos de bloco
mount                       # Pontos de montagem
```

**Rede e conectividade:**
```bash
ip addr show                # Interfaces de rede
systemctl status tor        # Status do Tor
curl --socks5 127.0.0.1:9050 http://check.torproject.org/
```

**Ferramentas de segurança:**
```bash
blackb0x-format /dev/sdX    # Formatar disco com LUKS+F2FS
blackb0x-locale-setup       # Configurar idioma
blackb0x-tor-start          # Iniciar Tor Browser
```

---


## Segurança e Criptografia

### Criptografia LUKS

O BlackB0x utiliza criptografia LUKS para proteger todos os dados do sistema.

**Características:**
- **Criptografia AES-256** para máxima segurança
- **Desbloqueio via senha** durante o boot
- **Proteção completa** do sistema de arquivos
- **Chaves de recuperação** opcionais

**Gerenciamento:**
```bash
# Verificar status da criptografia
cryptsetup status cryptroot

# Adicionar nova chave (backup)
sudo cryptsetup luksAddKey /dev/sdX1

# Remover chave antiga
sudo cryptsetup luksRemoveKey /dev/sdX1

# Backup do cabeçalho LUKS
sudo cryptsetup luksHeaderBackup /dev/sdX1 --header-backup-file backup.img
```

### Sistema de Arquivos F2FS

O F2FS oferece performance otimizada e recursos de segurança avançados.

**Vantagens:**
- **Otimizado para SSDs** e dispositivos flash
- **Garbage collection** eficiente
- **Compressão transparente** opcional
- **Verificação de integridade** automática

### Sistemas Temporários

**Configuração de segurança:**
- `/tmp` montado como tmpfs (RAM)
- `/var/tmp` montado como tmpfs (RAM)
- `/var/log` montado como tmpfs (RAM)
- Swap via zram (comprimido em RAM)

**Benefícios:**
- Nenhum dado temporário gravado no disco
- Limpeza automática na reinicialização
- Performance superior
- Maior privacidade

---

## Solução de Problemas

### Problemas Comuns

**1. Esqueci a senha LUKS**
- **Solução:** Use chave de backup se configurada
- **Prevenção:** Sempre configure múltiplas chaves
- **Último recurso:** Reinstalação completa

**2. Tor Browser não inicia**
```bash
# Verificar status do serviço Tor
systemctl status tor

# Reiniciar serviço Tor
sudo systemctl restart tor

# Iniciar manualmente
/usr/local/bin/blackb0x-tor-start
```

**3. Problemas de rede**
```bash
# Verificar interfaces
ip addr show

# Reiniciar NetworkManager
sudo systemctl restart NetworkManager

# Verificar conectividade Tor
curl --socks5 127.0.0.1:9050 http://check.torproject.org/
```

**4. Sistema lento**
- Verifique uso de RAM: `free -h`
- Monitore processos: `top` ou `htop`
- Verifique espaço em disco: `df -h`
- Reinicie se necessário

### Logs e Diagnóstico

**Visualizar logs do sistema:**
```bash
# Logs do systemd
journalctl -f

# Logs do Tor
sudo journalctl -u tor

# Logs do LightDM
sudo journalctl -u lightdm

# Logs do kernel
dmesg | tail
```

### Recuperação do Sistema

**Modo de recuperação:**
1. Selecione "Modo de Recuperação" no GRUB
2. Digite a senha LUKS se solicitada
3. Acesse o terminal como root
4. Execute comandos de diagnóstico e reparo

**Comandos de recuperação:**
```bash
# Verificar sistema de arquivos
fsck.f2fs /dev/mapper/cryptroot

# Reparar sistema de arquivos
fsck.f2fs -f /dev/mapper/cryptroot

# Reconfigurar GRUB
update-grub

# Regenerar initramfs
update-initramfs -u
```

---

## Suporte e Recursos

### Documentação Adicional

- **Website oficial:** https://blackb0x.com.br
- **Documentação técnica:** https://blackb0x.com.br/docs
- **Suporte:** https://blackb0x.com.br/suporte
- **Relatórios de bugs:** https://blackb0x.com.br/bugs

### Comunidade

- **Fórum de usuários:** Discussões e dúvidas
- **Canal de suporte:** Ajuda técnica
- **Atualizações:** Novidades e releases

### Verificação de Integridade

Sempre verifique a integridade da ISO antes da instalação:

```bash
# Verificar MD5
md5sum -c BlackB0x-1.0-Terminal.iso.md5

# Verificar SHA256
sha256sum -c BlackB0x-1.0-Terminal.iso.sha256
```

---

## Conclusão

O **BlackB0x Linux** oferece uma plataforma segura e privada para suas atividades digitais. Com criptografia robusta, navegação anônima e interface intuitiva, é a escolha ideal para usuários que valorizam privacidade e segurança.

**Lembre-se:**
- Mantenha sempre backups de suas chaves LUKS
- Atualize o sistema regularmente
- Use senhas fortes e únicas
- Pratique bons hábitos de segurança digital

---

**BlackB0x Linux 1.0 "Terminal"**  
*Privacidade e Segurança em Primeiro Lugar*

© 2024 BlackB0x Project - https://blackb0x.com.br

