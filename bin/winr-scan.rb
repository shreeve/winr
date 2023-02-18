{
  contexts: [
    {
      begin: <<~"|".strip
        require "strscan"
        scanner = StringScanner.new("test string")
      |
    }
  ],
  tasks: [
    {
      name: "regexp_pattern",
      script: 'scanner.scan(/\w/)'
    },
    {
      name: "regexp_literal",
      script: 'scanner.scan(/test/)'
    },
    {
      name: "string",
      script: 'scanner.scan("test")'
    },
  ]
}
