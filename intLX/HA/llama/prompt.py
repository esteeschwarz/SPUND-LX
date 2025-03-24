def print_tuned_completion(temperature: float, top_p: float):
    response = completion("Write a sonnet about frogs", temperature=temperature, top_p=top_p)
    response = completion('Write a sonnet about frogs and tag all elements of figurative language with <idiom type="?1">?2</idiom>, where ?1 = of array["metaphor","idiom","metonyme","comparison"] and ?2 = the figurative element', temperature=temperature, top_p=top_p)
    print(f'[temperature: {temperature} | top_p: {top_p}]\n{response.strip()}\n')

print_tuned_completion(0.01, 0.01)