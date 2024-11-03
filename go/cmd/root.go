package cmd

import (
	"os"

	"github.com/spf13/cobra"
)

type RunEFunc func(cmd *cobra.Command, args []string) error

var rootCmd = &cobra.Command{
	Use:   "secretctl",
	Short: "A CLI to make secret handling easier",
	Long:  `A CLI to make secret handling easier`,
}

func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}
