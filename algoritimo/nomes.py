def substituir_letras(texto):
    mapa_substituicao = {
        'a': '@', 'b': '8', 'c': '<', 'e': '3', 'g': '6',
        'i': '1', 'o': '0', 'r': '4', 's': '5', 't': '7', 'z': '2'
    }
    
    texto_modificado = ''
    for char in texto.lower():
        texto_modificado += mapa_substituicao.get(char, char)
    
    return texto_modificado

# Solicita o nome do servidor
nome_servidor = input("Digite o nome do servidor: ")

# Aplica a substituição de letras
nome_modificado = substituir_letras(nome_servidor)

# Exibe o resultado
print(f"Nome do servidor modificado: {nome_modificado}")