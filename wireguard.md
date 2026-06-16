# Installazione di TailScale per soluzione simil VPN

## Cos'è WireGuard?

WireGuard è un protocollo VPN open source di nuova generazione, progettato per essere più veloce, sicuro e semplice rispetto ai protocolli tradizionali come OpenVPN e IPsec. 

Rispetto ad alternative più datate, utilizza un numero ridotto di righe di codice (meno di 5.000 contro le 600.000 di OpenVPN), rendendo più facile la sua implementazione, verifica e manutenzione. 

La sua leggerezza architetturale si traduce in prestazioni superiori e in un’esperienza di navigazione più fluida. 

WireGuard adotta un sistema client-server basato su chiavi crittografiche, utilizzando l’algoritmo ChaCha20 per la crittografia, evitando i rallentamenti tipici di protocolli più pesanti; 

inoltre, opera direttamente nel kernel Linux, aumentando ulteriormente velocità ed efficienza. WireGuard offre velocità elevate con un impatto quasi impercettibile sulle prestazioni. 

### Requisiti

Perché Wireguard possa parlare con l'esterno bisogna aprire una porta sul router riguardante l'ip statico del server e un ip pubblico statico o un servizio DDNS o di tunnel come `Cloudflare Tunnel` (gratuito) . Per evitare questo, aprire il manuale di `Tailscale.md`

## Installazione su OMV
installa il plugin di WireGuard.

Vai su *Tunnel* e creane uno nuovo: 
 - indica _nome_, la _scheda di rete_ da usare, _endpoint_ (che sarà in questo caso il nostro dominio o ip pubblico. eg.186.25.47.100. senza indicare subnet o altro. solo l'ip. Non serve nella configurazione del tunnel, ma del client) e _porta_.
 - Attiva _Configura iptables_ e puoi lasciare tutto così com'è perché verrà popolato in automatico (è il campo `Address`)

Vai su *Client* e creane uno nuovo: 
 - Dai un nome, specifica il `Numero del tunnel` e lascia tutto così come è. Ci penserà il plugin a aumentare l'adress e cambiare la Private Key. 

Genera il QR o scarica la configurazione e scansionalo/importalo nell'app

## Esempi:
### Tunnel:

[Interface]
Address = 10.192.1.254/24

SaveConfig = true
ListenPort = 51800
PrivateKey = easfasdasdasdaasf
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
PublicKey = 8asfasfasfasfasfasfasf
AllowedIPs = 10.192.1.1/32
PresharedKey = o2asfasfasfasfasfasfasf



### Client:
[Interface]
Address = 10.192.1.1/24
PrivateKey = cBasdasdasdasdasd

[Peer]
PublicKey = suwasdasdasdasdasdasd
PresharedKey = o2asdasdasdasdasdasda
Endpoint = 186.25.47.100:51800
AllowedIPs = 0.0.0.0/0
