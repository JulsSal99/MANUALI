# Installazione di TailScale per soluzione simil VPN

## Cos'è TailScale?

Tailscale non è un reverse proxy. È una rete VPN mesh basata su *WireGuard*.

Il suo scopo è collegare direttamente i tuoi dispositivi come se fossero nella stessa LAN privata.

Quando installi Tailscale:
_PC ↔ Raspberry ↔ telefono_

ogni dispositivo:
 - riceve un IP privato Tailscale (100.x.x.x)
 - crea tunnel WireGuard cifrati
 - comunica peer-to-peer quando possibile

Passa dai server Tailscale?
 - Per autenticazione e coordinamento: SÌ
Usa server Tailscale per:
 - login
 - scambio chiavi
 - discovery dispositivi

MA…
Il traffico dati normalmente NON passa dai loro server. Nella maggior parte dei casi: connessione diretta P2P WireGuard.

Quindi:
 - bassa latenza
 - banda piena
 - niente relay centrale

### Tailscale NON richiede aprire porte
Perché:
 - usa NAT traversal automatico
 - hole punching
 - relay DERP se necessario

Quindi nella maggior parte dei casi:
installi → login → funziona
senza toccare il router.

### Limiti: 
Piano gratuito
 - fino a 100 dispositivi personali
 - nessun limite di traffico dichiarato
 - banda dipende dalla tua rete

Quindi:
 - se P2P → velocità quasi LAN
 - se relay DERP → più lenta

### Wireguard al contrario:
Richiede normalmente:
 - apertura porta sul router
 - port forwarding
 - IP pubblico o DDNS

### Alternative
Acquistare un dominio e fare reverse proxy con NGIX o usare Headless

## Installazione
```bash
sudo apt update
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

### In caso di problemi Docker:
```bash
sudo mv /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/docker.list.disabled
```

Poi:
```bash
sudo apt update
```

Installa Tailscale manualmente
```bash
sudo apt install -y tailscale
```

## per il routing verso la rete LAN:
1) Abilita IP forwarding (Linux)

```bash
sudo sysctl -w net.ipv4.ip_forward=1
```

Per renderlo permanente:

```bash
sudo nano /etc/sysctl.conf
```

```bash
net.ipv4.ip_forward=1
```

NOTA per salvare: CTRL+O -> ENTER -> CTRL+X
1) Riavvia Tailscale con subnet advertising
```bash
sudo tailscale up --advertise-routes=192.168.1.0/24
```

Dal sito di configurazione tailscale, approva il nodo della route: 192.168.1.0/24